//一番上のページにスクロールする
$(function() {
  // 「TOPに戻る」ボタンがクリックされた時の動きを指定します。
  $("#click").click(function() {
    // ページの一番上までスクロールさせます。
    $('body, html').scrollTop(0);
  });
});