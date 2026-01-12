//
// JS -> CREATE DOWNLOAD FILE

function VMK_Download(File_Name, Noi_Dung) {
  var elem = document.createElement("a");
  elem.setAttribute(
    "href",
    "data:text/plain;charset=utf-8," + encodeURIComponent(Noi_Dung)
  );
  elem.setAttribute("download", File_Name);
  elem.style.display = "none";
  document.body.appendChild(elem);
  elem.click();
  document.body.removeChild(elem);
}

VMK_Download("ABC.TXT", "Hello");
