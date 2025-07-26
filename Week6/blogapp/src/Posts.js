// src/Posts.js
import React, { Component } from 'react';
import Post from './Post';

class Posts extends Component {
  constructor(props) {
    super(props);
    this.state = {
      posts: [],
      hasError: false
    };
  }

  // Fetching data
  loadPosts() {
    fetch("https://jsonplaceholder.typicode.com/posts")
      .then(response => response.json())
      .then(data => {
        const postsArray = data.slice(0, 5).map(
          post => new Post(post.userId, post.id, post.title, post.body)
        );
        this.setState({ posts: postsArray });
      })
      .catch(error => {
        console.error("Error fetching posts:", error);
        this.setState({ hasError: true });
      });
  }

  // Lifecycle: componentDidMount
  componentDidMount() {
    this.loadPosts();
  }

  // Lifecycle: componentDidCatch
  componentDidCatch(error, info) {
    alert("An error occurred while rendering the posts.");
    console.error("Error:", error, info);
    this.setState({ hasError: true });
  }

  // Render method
  render() {
    if (this.state.hasError) {
      return <h2>Something went wrong while loading posts.</h2>;
    }

    return (
      <div>
        <h1>Blog Posts</h1>
        {this.state.posts.map(post => (
          <div key={post.id} style={{border: '1px solid #ccc', margin: '10px', padding: '10px'}}>
            <h3>{post.title}</h3>
            <p>{post.body}</p>
          </div>
        ))}
      </div>
    );
  }
}

export default Posts;
