// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
// require("turbolinks").start() // JavaScriptを正常に動作させるため無効化
require("@rails/activestorage").start()
require("channels")
require("../items/fee_calculation")  // 商品出品・編集機能において金額計算を行うため追加
require("../purchase_histories/card") // 商品購入機能においてAPIによるカード決済を行うため追加

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
