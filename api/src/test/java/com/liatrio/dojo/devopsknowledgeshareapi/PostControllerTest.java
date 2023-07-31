package com.liatrio.dojo.devopsknowledgeshareapi;

import static org.mockito.MockitoAnnotations.initMocks;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.setup.MockMvcBuilders.standaloneSetup;

import org.json.JSONObject;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

@SpringBootTest
@AutoConfigureMockMvc()
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class PostControllerTest {
    @Autowired
    private MockMvc mockMvc;

    @InjectMocks
    PostController mockPost;

    @Mock
    PostRepository mockPr;

    private JSONObject testPost;

    @BeforeAll
    public void setup() throws Exception {
        initMocks(this);
        this.mockMvc = standaloneSetup(mockPost).build();

        testPost = new JSONObject();

        testPost.put("firstName", "John");
        testPost.put("title", "My First Post");
        testPost.put("link", "https://www.example.com/blog/post-1");
    }

    @Test
    public void getPostsResponse() throws Exception {
        this.mockMvc.perform(get("/posts")).andDo(print()).andExpect(status().isOk());
    }

    @Test
    public void postPostsFirstName() throws Exception {
        this.mockMvc.perform(
                post("/posts").content(testPost.toString()).with(csrf()).contentType(MediaType.APPLICATION_JSON))
                .andDo(print()).andExpect(status().isOk());
    }

    @Test
    public void deletePostsFirstName() throws Exception {
        this.mockMvc.perform(
                post("/posts").content(testPost.toString()).with(csrf()).contentType(MediaType.APPLICATION_JSON))
                .andDo(print()).andExpect(status().isOk());
        this.mockMvc.perform(delete("/posts/1/").with(csrf())).andDo(print()).andExpect(status().isOk());
    }
}