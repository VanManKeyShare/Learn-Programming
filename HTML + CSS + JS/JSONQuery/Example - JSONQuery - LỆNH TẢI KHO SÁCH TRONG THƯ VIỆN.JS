//
// Example - JSONQuery -> LỆNH TẢI KHO SÁCH TRONG THƯ VIỆN

var ApiUrl = "https://zzz.com";
var Bearer_Key = "xxx";
var SoLuongSachToiDaTrong1Kho = 3000;

var vmk =
  await import("https://cdn.jsdelivr.net/npm/@jsonquerylang/jsonquery@5.1.1/lib/jsonquery.min.js");

var ArrayIDKho = [];
var ArrayTenKho = [];

// TẢI DANH SÁCH KHO SÁCH
await fetch(`${ApiUrl}/api/LoaiKho/IndexByTreeCountBook`, {
  credentials: "include",
  headers: {
    "User-Agent":
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:147.0) Gecko/20100101 Firefox/147.0",
    Accept: "*/*",
    "Accept-Language": "en-US,en;q=0.9",
    authorization: `Bearer ${Bearer_Key}`,
    "Sec-GPC": "1",
    "Sec-Fetch-Dest": "empty",
    "Sec-Fetch-Mode": "cors",
    "Sec-Fetch-Site": "same-site",
    Priority: "u=0",
  },
  referrer: "https://zzz.com/",
  method: "POST",
  mode: "cors",
})
  .then((response) => response.text())
  .then((dulieu) => {
    dulieu = JSON.parse(dulieu);
    dulieu = vmk.jsonquery(dulieu, `.Item | .ListKhoSach`);
    for (var i = 0; i < dulieu.length; i++) {
      if (dulieu[i].CountBook > 0) {
        if (dulieu[i].CountBook > SoLuongSachToiDaTrong1Kho) {
          SoLuongSachToiDaTrong1Kho = dulieu[i].CountBook;
        }
        ArrayIDKho.push(dulieu[i].Id);
        ArrayTenKho.push(dulieu[i].Ten);
      }
    }
    TAI_KHO_SACH(0, ArrayIDKho, ArrayTenKho);
  })
  .catch((err) => console.error(err));

// FUNCTION TẢI SÁCH TRONG KHO
async function TAI_KHO_SACH(STT, ArrayIDKho, ArrayTenKho) {
  if (STT >= ArrayIDKho.length || ArrayIDKho.length != ArrayTenKho.length) {
    return;
  }
  var Body = "";
  var idKho = ArrayIDKho[STT];
  var TenKho = ArrayTenKho[STT];
  var Header = `Kho sách: ${TenKho}\r\nSTT,Tên Kho,MKS,Mã ĐKCB,Tên sách,Ngày vào sổ`;
  await fetch(
    `${ApiUrl}/api/KhoSach/GetListSCB?idKho=${idKho}&isColapse=false&ShowDeleted=false&isAvailable=false`,
    {
      credentials: "include",
      headers: {
        "User-Agent":
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:147.0) Gecko/20100101 Firefox/147.0",
        Accept: "*/*",
        "Accept-Language": "en-US,en;q=0.9",
        "Content-Type": "application/json",
        authorization: `Bearer ${Bearer_Key}`,
        "Sec-GPC": "1",
        "Sec-Fetch-Dest": "empty",
        "Sec-Fetch-Mode": "cors",
        "Sec-Fetch-Site": "same-site",
        Priority: "u=0",
      },
      referrer: "https://zzz.com/",
      body: `{\"idKho\":\"${idKho}\",\"page\":1,\"pageSize\":${SoLuongSachToiDaTrong1Kho},\"isSortMaDKCB\":true}`,
      method: "POST",
      mode: "cors",
    },
  )
    .then((response) => response.text())
    .then((dulieu) => {
      dulieu = JSON.parse(dulieu);
      dulieu = vmk.jsonquery(
        dulieu,
        `.Item.List_SachCB
			| filter(.IsDeleted == false)
			| pick(.MaKiemSoat,.MaKSCB,.TenSach,.NgayVaoSo)
		`,
      );
      for (var i = 0; i < dulieu.length; i++) {
        var MaKiemSoat = dulieu[i].MaKiemSoat;
        var MaKSCB = dulieu[i].MaKSCB;
        var TenSach = dulieu[i].TenSach.replace(/[\r\n]+/gm, "").trim();
        var NgayVaoSo = dulieu[i].NgayVaoSo;
        var [y, m, d] = NgayVaoSo.split("T")[0].split("-");
        NgayVaoSo = `${d}/${m}/${y}`;

        Body += `${i + 1},"${TenKho}",${MaKiemSoat},${MaKSCB},"${TenSach}",${NgayVaoSo}\r\n`;
      }
      SaveFile(Header + "\r\n" + Body, TenKho + ".csv");

      TAI_KHO_SACH(STT + 1, ArrayIDKho, ArrayTenKho);
    })
    .catch((err) => console.error(err));
}

// FUNCTION TẢI FILE VỀ MÁY
function SaveFile(DATA, FileName) {
  // ENCODING -> UTF8 WITH BOM
  const blob = new Blob(["\uFEFF" + DATA], { type: "text/html;charset=utf-8" });
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = FileName;
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
  URL.revokeObjectURL(url);
}
