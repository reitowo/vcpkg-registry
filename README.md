# vcpkg-ports

k1ee's custom vcpkg ports.

## Usage

Enable `registries` feature flag in vcpkg and write a `vcpkg-configuration.json` file like this in your project's root directory, and you're good to go.

```json
{
    "registries": [
        {
            "kind": "git",
            "repository": "https://github.com/k1ee/vcpkg-ports.git",
            "packages": [ "List the packages that you want to use from my ports here" ]
        }
    ]
}
```

## Thanks

Thanks [Chlorie](https://github.com/Chlorie/vcpkg-ports)