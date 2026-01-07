//
// JS -> KHÓA CHỨC NĂNG COPY, CUT, CHUỘT PHẢI

$(document).ready(function () {
  $(this).bind("copy", function (e) {
    e.preventDefault();
  });
  $(this).bind("cut", function (e) {
    e.preventDefault();
  });
  $(this).bind("contextmenu", function (e) {
    e.preventDefault();
  });
  $(this).mouseup(function (e) {
    if (e.which === 3) {
      e.preventDefault();
    }
  });
});
