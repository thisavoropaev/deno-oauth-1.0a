# OAuth 1.0a Request Authorization for Deno

---
**About this fork**  
Maintained by [Andrei Varapayeu](https://github.com/thisavoropaev)

This is not just a fork, but a modernized, maintained, and published version:
- Uses [JSR](https://jsr.io) packages instead of legacy `https` imports
- All tests updated and fixed for reliability
- Fully migrated to and tested on **Deno 2.x**
- Published on [JSR](https://jsr.io/@andreivarapayeu/oauth-one-a)

Feel free to reach out via [GitHub](https://github.com/thisavoropaev) for any questions or suggestions.
---


[![CI][test-badge]][test-url]
[![JSR][jsr-badge]][jsr-url]

OAuth 1.0a Request Authorization module for Deno with JSR and std packages
support. This is an updated fork with modern Deno ecosystem integration.

- [Usage](#usage)
- [Test](#test)
- [Release process](#release-process)
- [License](#license)

[test-badge]: https://github.com/thisavoropaev/deno-oauth-1.0a/actions/workflows/test.yml/badge.svg
[test-url]: https://github.com/thisavoropaev/deno-oauth-1.0a/actions/workflows/test.yml
[jsr-badge]: https://jsr.io/badges/@andreivarapayeu/oauth-one-a
[jsr-url]: https://jsr.io/@andreivarapayeu/oauth-one-a

## Release process

To publish a new version to JSR and GitHub Releases:

1. Make sure your changes are pushed to the `main` branch and CI passes (tests, lint, fmt).
2. Update the `version` field in `deno.json` (e.g., `1.2.3`).
3. (Optionally) Update `CHANGELOG.md` with release notes.
4. Create a git tag matching the new version (e.g., `v1.2.3`):
   ```sh
   git tag v1.2.3
   git push origin v1.2.3
   ```
5. The release workflow will:
   - Ensure the latest CI on `main` is green
   - Run checks again
   - Publish the package to [JSR](https://jsr.io/@andreivarapayeu/oauth-one-a)
   - Create a GitHub Release with this tag

**Note:** No automatic release or publication happens on push to `main` — only when you push a new tag.

## Usage

Use [OAuthClient][doc-OAuthClient] object to sign an HTTP request with consumer
and token credentials. You get an `Authorization` header that can be added to an
actual request.

```typescript
import * as oauth from "jsr:@andreivarapayeu/oauth-one-a";

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

[doc-OAuthClient]: https://jsr.io/@andreivarapayeu/oauth-one-a/doc/~/OAuthClient

## Test

```console
$ git clone https://github.com/andreivarapayeu/deno-oauth-one-a
$ cd deno-oauth-one-a
$ deno test --allow-all
```

## License

MIT License.

This codebase is a major rework of [ddo/oauth-1.0a][ddo] v2.2.6 in Deno. Design
and many of the tests are inherited from the original work, a copy of which is
kept in the ["original" branch][original].

[ddo]: https://github.com/ddo/oauth-1.0a
[original]: https://github.com/snsinfu/deno-oauth-one-a/tree/original
