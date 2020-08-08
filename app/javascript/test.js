//一番上のページにスクロールする
$(function() {
  // 「TOPに戻る」ボタンがクリックされた時の動きを指定します。
  $("[id=click]").click(function() {
    // ページの一番上までスクロールさせます。
    $('body, html').scrollTop(0);
  });
});

$(function() {  //フェードイン・アウト  https://adan.jp.net/blog/programing/1753
  $('.notification').fadeIn("slow", function () {
    $(this).delay(3000).fadeOut("slow");
  });
});
