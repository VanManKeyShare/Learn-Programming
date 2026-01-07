//
// JS -> CHỌN NGẪU NHIÊN INPUT RADIO

function RANDOM_INT_FROM_INTERVAL(min, max) {
  return Math.floor(Math.random() * (max - min + 1) + min);
}

$("div.panel.panel-default.box-question").each(function () {
  var soluong_dapan = $(this).find("div.row > ul.pickAnswer > li").length;
  var chon_dapan_ngaunhien = RANDOM_INT_FROM_INTERVAL(1, soluong_dapan);
  $(this)
    .find(
      "div.row > ul.pickAnswer > li:nth-child(" +
        chon_dapan_ngaunhien +
        ") > input"
    )
    .prop("checked", true);
});
