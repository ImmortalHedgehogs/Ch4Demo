import type { GetServerSideProps, NextPage } from "next";
import {
  ChangeEventHandler,
  FormEvent,
  FormEventHandler,
  useState,
} from "react";
import Head from "next/head";
import Layout from "../components/Layout/Layout";
import LoadingMessage from "../components/LoadingMessage/LoadingMessage";
import Table from "../components/Table/Table";
import ShareForm from "../components/ShareForm/ShareForm";
import styles from "./index.module.scss";
import { performDelete, postFormData } from "../utils/api";
import { isPropertyAccessChain } from "typescript";

export interface Blog {
  id?: string;
  title: string;
  firstName: string;
  link: URL;
  imageUrl?: URL;
  datePosted?: string;
}

export interface Props {
  initalBlogList: Blog[];
  enableImageURL: boolean;
}

const Home: NextPage<Props> = ({ initalBlogList, enableImageURL }) => {
  let blogTable: JSX.Element;

  const [blogList, setBlogList] = useState(initalBlogList);

  const handleDeleteBlog: Function = (id: string) => {
    performDelete(id);
    setBlogList(blogList.filter((blog) => blog.id !== id));
  };

  const handleSubmit: Function = async (event: any, newBlog: Blog) => {
    const response: any = await postFormData(newBlog);
    const processedBlog: Blog = await response.json();
    setBlogList((blogList) => [...blogList, processedBlog]);
  };

  if (blogList) {
    blogTable = (
      <Table
        blogList={blogList}
        handleDelete={handleDeleteBlog}
        enableImageURL={enableImageURL}
      />
    );
  } else {
    blogTable = <LoadingMessage>(404) Blog data not found</LoadingMessage>;
  }

  return (
    <Layout title="DevOps Knowledge Share">
      <div>
        <Head>
          <title>DKS</title>
          <meta
            name="description"
            content="Generated by Core Engineering Capability Team"
          />
          <link rel="icon" href="/favicon.ico" />
        </Head>

        <main>
          <div className={styles.bannerWrapper}>
            <div className={styles.mainBanner}>
              <h2>Hedgehogs Are The Shit!</h2>
              <p>
                Let&apos;s grow this DevOps Community strong by sharing your
                favorite article or blog post on DevOps culture, tools, platform
                and more!
              </p>
            </div>
          </div>
          <div className={styles.shareForm}>
            <ShareForm
              enableImageURL={enableImageURL}
              handleSubmit={handleSubmit}
            />
          </div>
          <div className={styles.bloglist}>{blogTable}</div>
        </main>
      </div>
    </Layout>
  );
};

export const getServerSideProps: GetServerSideProps = async ({ res }) => {
  try {
    const res = await fetch(process.env["KNOWLEDGE_SHARE_API"] + "/posts");
    const initalBlogList: Blog[] = await res.json();

    return {
      props: {
        initalBlogList,
        enableImageURL: process.env["ENABLE_IMAGE_URL"] || false,
      },
    };
  } catch {
    res.statusCode = 404;
    return {
      props: { enableImageURL: process.env["ENABLE_IMAGE_URL"] || false },
    };
  }
};

export default Home;