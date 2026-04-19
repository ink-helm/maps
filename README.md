# maps

Helm chart registry for the `ink-helm` GitHub Pages repository.

## Repository layout

- `main`: chart sources and the release workflow
- `gh-pages`: published Helm repo index and packaged chart metadata

## Usage

```console
helm repo add inkhelm https://ink-helm.github.io/maps
helm repo update
helm search repo inkhelm
```

## References

- https://medium.com/@gerkElznik/provision-a-free-personal-helm-chart-repo-using-github-583b668d9ba4
