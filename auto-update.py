import requests
import pathlib 
import re
import hashlib
import json
import version_parser
import git

def parse_vcpkg_from_github(portfile):
    begin = portfile.find("vcpkg_from_github(")
    if begin == -1:
        return None
    
    begin += len("vcpkg_from_github(")
    end = portfile.find(")", begin)

    interest = portfile[begin:end]
    splits = re.split(' |\n', interest)
    items = []
    for split in splits:
        split = split.strip()
        if len(split) > 0:
            items.append(split)
    
    if len(items) % 2 != 0:
        return None

    ret = {}
    for i in range(0, len(items), 2):
        ret[items[i]] = items[i + 1]

    return ret 

def github_get_latest_commit(repo, head):
    r = requests.get(f"https://api.github.com/repos/{repo}/commits/{head}", proxies={'http':'http://127.0.0.1:10809', 'https':'http://127.0.0.1:10809'})
    j = r.json()
    return j['sha']

def github_get_archive(repo, commit):
    r = requests.get(f"https://github.com/{repo}/archive/{commit}.tar.gz", proxies={'http':'http://127.0.0.1:10809', 'https':'http://127.0.0.1:10809'})
    return hashlib.sha512(r.content).hexdigest() 


git_repo = git.Repo("./")
git_repo.git.add('.')


# Try Update All Ports
ports_folder = pathlib.Path("./ports")
for port in ports_folder.iterdir():
    vcpkg_json_path = port.joinpath("vcpkg.json")
    portfile_cmake_path = port.joinpath("portfile.cmake")
    if vcpkg_json_path.exists() and portfile_cmake_path.exists():
        print("Updating " + port.name)
        # Parse vcpkg_from_github
        portfile_str = portfile_cmake_path.read_text()
        github_meta = parse_vcpkg_from_github(portfile_str)
        if github_meta is None:
            continue

        github_repo = github_meta['REPO']
        github_ref = github_meta['REF']
        github_sha = github_meta['SHA512']
        github_head = github_meta['HEAD_REF']

        latest_commit = github_get_latest_commit(github_repo, github_head)
        if latest_commit == github_ref :
            print("- Already up-to-date.")
            continue

        # Calculate Latest SHA512
        latest_sha512 = github_get_archive(github_repo, latest_commit)
        print(f"- Latest commit {latest_commit}")
        print(f"- Latest sha512 = {latest_sha512}")

        # Update portfile.cmake
        portfile_str = portfile_str.replace(github_sha, latest_sha512)
        portfile_str = portfile_str.replace(github_ref, latest_commit)
        portfile_cmake_path.write_text(portfile_str)

        # Update vcpkg.json
        vcpkg_json = json.loads(vcpkg_json_path.read_text())
        version = version_parser.Version(vcpkg_json['version-string'])
        version._build_version += 1
        vcpkg_json['version-string'] = str(version)
        vcpkg_json_path.write_text(json.dumps(vcpkg_json))

# Update Git
git_repo = git.Repo("./")
git_repo.git.add('.')
