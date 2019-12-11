/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import "bootstrap";

import Vue from 'vue/dist/vue.esm.js';
import CreatePost from '../post/create.vue';
import AllPosts from '../post/posts.vue';
import Post from '../post/post.vue';


import TurbolinksAdapter from 'vue-turbolinks';
import axios from 'axios'

let token = document.getElementsByName('csrf-token')[0].getAttribute('content');
axios.defaults.headers.common['X-CSRF-Token'] = token;
axios.defaults.headers.common['Accept'] = 'application/json';


Vue.component('create-post', CreatePost);
Vue.component('posts', AllPosts);
Vue.component('post', Post);



document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
        el: '[data-behavior="vue"]',
    })
});

