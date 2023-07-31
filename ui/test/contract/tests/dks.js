import { pactWith } from "jest-pact";
import { Matchers } from "@pact-foundation/pact";
import path from "path";
const { like } = Matchers;
import api from "../api/index.js";

pactWith(
  {
    consumer: "DKS UI",
    provider: "DKS API",
    dir: path.resolve("contracts"),
    logDir: path.resolve("logs"),
    logFileName: "log",
  },
  (provider) => {
    let client;
    const POSTS_BODY = [
      {
        objectId: like(0),
        firstName: like("Ethan"),
        title: like("Awesome Blog"),
        link: like("https://blog.com"),
        datePosted: like("Yesteryear"),
        dateAsDate: like("2022-03-08T16:27:50.911Z"),
        id: like(0),
      },
    ];
    beforeEach(() => {
      client = api.postsList.bind(null, provider.mockService.baseUrl, {});
    });

    describe("Posts list endpoint", () => {
      beforeEach(() =>
        provider.addInteraction({
          state: "Posts list provided",
          uponReceiving: "A request for posts",
          willRespondWith: {
            status: 200,
            headers: {
              "Content-Type": "application/json",
            },
            body: POSTS_BODY,
          },
          withRequest: {
            method: "GET",
            path: "/posts",
            headers: {},
          },
        })
      );

      it("Will return a list of posts", async () => {
        const resp = await client();
        const { posts } = await resp.json();
      });
    });
  }
);
