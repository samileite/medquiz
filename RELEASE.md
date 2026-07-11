# Release Checklist

Use this checklist before considering a production change finished.

1. Merge the feature branch into `main`.
2. Push `main` to `origin`.
3. Run:

```sh
npm run release:check
```

The check builds the app and confirms that local `main` matches `origin/main`.
Vercel deploys production from `main`, so a feature branch alone is not enough
for changes to appear at `https://medquiz-ufpb.vercel.app/`.
