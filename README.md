# Lightweight OAuth 1.0a Client for Edge Runtimes and Serverless

[test-badge]: https://github.com/thisavoropaev/oauth-1.0a/actions/workflows/test.yml/badge.svg
[test-url]: https://github.com/thisavoropaev/oauth-1.0a/actions/workflows/test.yml
[jsr-badge]: https://jsr.io/badges/@thisavoropaev/oauth-1a
[jsr-url]: https://jsr.io/@thisavoropaev/oauth-1a

[![CI][test-badge]][test-url] [![JSR][jsr-badge]][jsr-url]

Maintained by [Andrei Varapayeu](https://github.com/thisavoropaev)

**Edge & Cloud Ready:** This library is fully compatible with:

- **Vercel Edge Functions**
- **Cloudflare Workers**
- **Deno Deploy**
- **Node.js**

It is designed to run in modern, standards-compliant JavaScript runtimes,
including edge/serverless platforms. No Node.js built-ins or legacy APIs are
required. Works out of the box for edge-native use cases (fetch, crypto, URL,
etc.).

**About This Project**

More than just a fork, this is a modernized, actively maintained, and officially
published version with the following improvements:

- Uses [JSR](https://jsr.io) packages instead of legacy `https` imports
- All tests updated and fixed for reliability
- Fully migrated to and tested on **Deno 2.x**
- Published on [JSR](https://jsr.io/@thisavoropaev/oauth-1a)

Feel free to reach out via [GitHub](https://github.com/thisavoropaev) for any
questions or suggestions.

## Local Development: Pre-push Checks

This repository includes a local git pre-push hook to help ensure code quality.
Before every push, the following will run automatically:

- `deno fmt` (formatting)
- `deno lint` (linting)
- `deno test --allow-all` (tests)

If any check fails, the push will be blocked.

To enable the pre-push hook after cloning or pulling:

```sh
sh setup-git-hooks.sh
```

This will symlink the hook from `.githooks/pre-push` to `.git/hooks/pre-push`.

## Usage

Use [OAuthClient][doc-OAuthClient] object to sign an HTTP request with consumer
and token credentials. You get an `Authorization` header that can be added to an
actual request.

```typescript
import * as oauth from "jsr:@thisavoropaev/oauth-1a";

const client = new oauth.OAuthClient({
  consumer: {
    key: "appkey-0123456789abcdef",
    secret: "appsecret-00112233445566778899aabbccddeeff",
  },
  signature: oauth.HMAC_SHA1,
});

const auth = oauth.toAuthHeader(client.sign(
  "PATCH",
  "https://api.example.com/profile",
  {
    token: {
      key: "userkey-abcdef0123456789",
      secret: "usersecret-aabbccddeeff00112233445566778899",
    },
    body: new URLSearchParams({ status: "busy" }),
  },
));

console.log("Authorization:", auth);
```

[doc-OAuthClient]: https://jsr.io/@thisavoropaev/oauth-1a/doc/~/OAuthClient

## Test

```console
$ git clone https://github.com/thisavoropaev/deno-oauth-1a
$ cd oauth-1.0a
$ deno test --allow-all
```

## Release process

To publish a new version to JSR and GitHub Releases:

1. Make sure all changes are merged into the `main` branch and that CI passes
   (tests, lint, formatting).
2. Update the `version` field in `deno.json` (for example, `1.2.3`).
3. (Optional) Update `CHANGELOG.md` with release notes.
4. Create a git tag that matches the new version (for example, `v1.2.3`):
   ```sh
   git tag v1.2.3
   git push origin v1.2.3
   ```
5. After pushing the tag, the release workflow will automatically:
   - Check formatting, lint, and run tests
   - Verify that the tag version matches the version in `deno.json`
   - Publish the package to [JSR](https://jsr.io/@thisavoropaev/oauth-1a) using
     OIDC (no token required)
   - Create a GitHub Release for this tag

**Important:** Publishing only happens when you push a new tag that matches the
version in `deno.json`. Pushing to `main` does not trigger a release
automatically.

## License

MIT License.

This codebase is a major rework of [ddo/oauth-1.0a][ddo] v2.2.6 in Deno. Design
and many of the tests are inherited from the original work, a copy of which is
kept in the ["original" branch][original].

[ddo]: https://github.com/ddo/oauth-1.0a
[original]: https://github.com/snsinfu/deno-oauth-1a/tree/original
