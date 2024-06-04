// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "jquery"
import "popper.js"
import "bootstrap"

import "../stylesheets/application"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// ★の評価を追加するために追記
import Raty from "raty.js"
window.raty = function(elem,opt){
  let raty = new Raty(elem,opt)
  raty.init();
  return raty;
}

// javascriptを読み込むための記述を追加
// 参照記事変更のため、コメントアウト
  // require jquery.min;
  // require jquery.raty;

// ★評価のために追記
// jqueryの呼び出し
// window.$ = window.jQuery = require('jquery');

// エラーへの対応のためturbolinkを無効化（参照記事にあるものもあった、、、）
