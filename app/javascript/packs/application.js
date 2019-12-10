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
import TurbolinksAdapter from 'vue-turbolinks';

Vue.component('create-post', CreatePost);

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
        el: '[data-behavior="vue"]',
    })
});

