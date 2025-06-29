# OAuth 1.0a Request Authorization for Deno

[![Test Status][test-badge]][test-url] [![JSR][jsr-badge]][jsr-url]

OAuth 1.0a Request Authorization module for Deno with JSR and std packages support. This is an updated fork with modern Deno ecosystem integration.

- [Usage](#usage)
- [Test](#test)
- [License](#license)

[test-badge]: https://github.com/andreivarapayeu/deno-oauth-1.0a/workflows/test/badge.svg
[test-url]: https://github.com/andreivarapayeu/deno-oauth-1.0a/actions?query=workflow%3Atest
[jsr-badge]: https://jsr.io/badges/@andreivarapayeu/oauth_1_0a
[jsr-url]: https://jsr.io/@andreivarapayeu/oauth_1_0a

## Usage

Use [OAuthClient][doc-OAuthClient] object to sign an HTTP request with consumer
and token credentials. You get an `Authorization` header that can be added to an
actual request.

```typescript
import * as oauth from "jsr:@andreivarapayeu/oauth_1_0a";

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

[doc-OAuthClient]: https://jsr.io/@andreivarapayeu/oauth_1_0a/doc/~/OAuthClient

## Test

```console
$ git clone https://github.com/andreivarapayeu/deno-oauth-1.0a
$ cd deno-oauth-1.0a
$ deno test --allow-all
```

## License

MIT License.

This codebase is a major rework of [ddo/oauth-1.0a][ddo] v2.2.6 in Deno. Design
and many of the tests are inherited from the original work, a copy of which is
kept in the ["original" branch][original].

[ddo]: https://github.com/ddo/oauth-1.0a
[original]: https://github.com/snsinfu/deno-oauth-1.0a/tree/original
