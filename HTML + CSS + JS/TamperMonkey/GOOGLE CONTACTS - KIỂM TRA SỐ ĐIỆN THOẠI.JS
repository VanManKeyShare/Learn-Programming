// ==UserScript==
// @name         GOOGLE CONTACTS - KIỂM TRA SỐ ĐIỆN THOẠI
// @namespace    http://rapid.vn
// @version      2025.11.25.0
// @description  GOOGLE CONTACTS - KIỂM TRA SỐ ĐIỆN THOẠI
// @author       Have a nice day :)
// @match        http*://*/*
// @icon         data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAMAAACdt4HsAAAAA3NCSVQICAjb4U/gAAAACXBIWXMAAAITAAACEwGa0+JEAAAAGXRFWHRTb2Z0d2FyZQB3d3cuaW5rc2NhcGUub3Jnm+48GgAAAKJQTFRF////VapVZsxNar9VY8ZVa7xeZr9Zar9VaMZVa8VaacNabMRYasBXa8BZasRZa8Faa8NbacFYa8NYa8JZacJYa8Jaa8JZasFYacJZasJaasJZasJZasJYasFaasNZasJZasFZasJZasFZacJZasJZa8JZasNZasJZasJYasJZasJZasJZasJZasJZasJZasJZasJZasJZa8JZasJZasJZasJZaecvbwAAADV0Uk5TAAMKDBITFBgbHzM0NTk8SkxOYmRoaXB0io6jpLC2vsDLzs/Q0dXX2Nvi5eru7/Dy8/j5/f6B8+AaAAAB2UlEQVRYw62X2XaCMBRFD9Ja7EBFKWIRtIOl1baA5f7/r/XBKQkxg/G8JYt91iK5uQNwQn6UpFlRVlVZZGkS+bBSEOcNcWryODCle5NFSxK1i0nPAPfGKzqp1djT8cMlKbUcKvHBnLSaD07z4ZoMtA5P8aMNGWkzkp/elIw1lZylNyMLzboOU7LStPP/ZCnhHMKNrcGGu4vBmqy1ZuNhTmdozsQvnaVDVHvL8wyW+7scW0B/7GK8e/8rcz57+GVf9zY/TCx4D/c/zHoCAFjY8MAd47AAgKC14oHb72OWCwDEljzweNyLAeS2/M3HcTMH/MaBp8ZH5MITRUiceEqQOvGUInPiKUMh7Hy1NjwVKPmN9/5Ta8FTiYpbv/UBwUHJU8UbvF4DgoOap4r7hZer7beMg4ankjvEaJ+jDg46ngruGutQcNDylPGBJDjoeUqFUOYcDHhKxMfEODwb8BR1nnPdaR9UfON3E4rooOIpl6U03kHJUyxNqqyDmm8DeVo/Oqj5bVqXFZa9g4bfFRZZads66PhdaZMW1zrU8/viKi/vdajlD+Vd3mDUn8YNhnuL495kObd57o2me6vr3mw7t/vuA8cFRh73oct97LvA4Ok++l5g+LYb//8B7ZNNbVPKYYQAAAAASUVORK5CYII=
// @grant        none
// ==/UserScript==

function CHECK_CURRENT_PATHNAME_EQUAL(PATHNAME) { if (window.location.pathname.toLowerCase() == PATHNAME.toLowerCase()) { return true } return false }
function CHECK_CURRENT_PATHNAME_INDEXOF(PATHNAME) { if (window.location.pathname.toLowerCase().indexOf(PATHNAME.toLowerCase()) > -1) { return true } return false }
function GET_CURRENT_HOST_NAME() { var PORT = ""; var HOST_NAME = ""; var TMP_CURRENT_HOST_NAME = location.host.toLowerCase(); var TMP = TMP_CURRENT_HOST_NAME.split(":"); if (TMP.length > 1) { HOST_NAME = TMP[0].toString().trim(); PORT = TMP[1].toString().trim() } else { HOST_NAME = TMP.toString().trim(); PORT = "80" } return HOST_NAME }
function CHECK_HOSTNAME_IN_ARRAY(JQUERY, LIST_HOST_NAME_SUPPORT, CURRENT_HOST_NAME) { var STATUS = false; JQUERY.each(LIST_HOST_NAME_SUPPORT, function (I, zVal) { if (CURRENT_HOST_NAME.indexOf(zVal.toLowerCase()) > -1) { STATUS = true } }); return STATUS }
function QueryS() { var QUERY_STRING = top.location.search.substring(1); var VARs = []; var HASH; var QUERY_STRING_TEMP = QUERY_STRING.split("#"); var QUERY_STRING_01 = QUERY_STRING_TEMP[0]; var QUERY_STRING_02 = QUERY_STRING_01.split("&"); for (var I = 0; I < QUERY_STRING_02.length; I++) { HASH = QUERY_STRING_02[I].split("="); VARs.push(HASH[0]); VARs[HASH[0]] = HASH[1] } return VARs }

(function () {
	'use strict';

    var JQueryIsLoaded = 0;

    if (document.readyState !== 'loading') {
        if (window.jQuery) {
            console.log($.fn);
            JQueryIsLoaded = 1;
        } else {
            console.log("%cJQUERY IS NOT LOADED", "background:red;color:white");
            /* SỬ DỤNG FIREFOX THÊM ADDONS REQUESTLY ĐỂ THÊM THƯ VIỆN JQUERY */
			/* TẠO RULE INSERT SCRIPTS CHÈN ĐOẠN LỆNH SAU */
			/* <script src="https://code.jquery.com/jquery-3.7.1.min.js" crossorigin="anonymous"></script> */
        }
    } else {
        document.addEventListener('DOMContentLoaded', function () {
            if (window.jQuery) {
                console.log($.fn);
                JQueryIsLoaded = 1;
            } else {
                console.log("%cJQUERY IS NOT LOADED", "background:red;color:white");
				/* SỬ DỤNG FIREFOX THÊM ADDONS REQUESTLY ĐỂ THÊM THƯ VIỆN JQUERY */
				/* TẠO RULE INSERT SCRIPTS CHÈN ĐOẠN LỆNH SAU */
				/* <script src="https://code.jquery.com/jquery-3.7.1.min.js" crossorigin="anonymous"></script> */
            }
        });
    }

    if (GET_CURRENT_HOST_NAME().trim().toUpperCase() == "CONTACTS.GOOGLE.COM"){
        if (top.location != location) { return }

        var Runner_Kiem_Tra_SDT;

        function SEARCH_MANG_VIEN_THONG(SDT) {
            var Index = -1;
            var KQ = 'Khác';
            if(SDT.length == 10){
                let DAU_SO = SDT.substring(0,3);
                let DS_DAU_SO_MOBIFONE = ['070','079','077','076','078','089','090','093'];
                let DS_DAU_SO_VINAPHONE = ['091','094','088','083','084','085','081','082'];
                let DS_DAU_SO_VIETTEL = ['086','096','097','098','039','038','037','036','035','034','033','032'];
                Index = DS_DAU_SO_MOBIFONE.findIndex(DS_DAU_SO_MOBIFONE => DS_DAU_SO_MOBIFONE === DAU_SO);
                if(Index > -1){KQ = 'MOBIFONE';}
                Index = DS_DAU_SO_VINAPHONE.findIndex(DS_DAU_SO_VINAPHONE => DS_DAU_SO_VINAPHONE === DAU_SO);
                if(Index > -1){KQ = 'VINAPHONE';}
                Index = DS_DAU_SO_VIETTEL.findIndex(DS_DAU_SO_VIETTEL => DS_DAU_SO_VIETTEL === DAU_SO);
                if(Index > -1){KQ = 'VIETTEL';}
            }
            return KQ;
        }

        function KIEM_TRA_SO_DIEN_THOAI() {
            console.log("KIỂM TRA SỐ ĐIỆN THOẠI");
            Runner_Kiem_Tra_SDT = setInterval(function(){
                var PATH_XEM_DANH_BA_CA_NHAN = '/person/';
                if(CHECK_CURRENT_PATHNAME_INDEXOF(PATH_XEM_DANH_BA_CA_NHAN) != true){return;}
                if($('input[aria-label="Phone"]').length == 0){return;}
                $('input[aria-label="Phone"]').each(function() {
                    if($(this).prop('title') != ""){return;}
                    if($(this).val().trim() == ""){return;}
                    let SDT = $(this).val().trim();
                    SDT = SDT.replaceAll(' ','');
                    $(this).val(SDT);
                    $(this).prop('title',SDT);
                    let TEN_MANG_VIEN_THONG = SEARCH_MANG_VIEN_THONG(SDT);
                    if($(this).parent().find("span#vmk_name_nha_mang").length == 0){
                        $(this).parent().prepend('<span id="vmk_name_nha_mang" style="color:red;cursor:pointer">' + TEN_MANG_VIEN_THONG + '</span>&nbsp;&nbsp;');
                    }
                });
            },1000);
        }

        var TEMP_B1 = "";
        TEMP_B1 += "<script>" + SEARCH_MANG_VIEN_THONG.toString() + "</script>";
        TEMP_B1 += "<script>" + KIEM_TRA_SO_DIEN_THOAI.toString() + "</script>";
        TEMP_B1 += "<script>" + CHECK_CURRENT_PATHNAME_INDEXOF.toString() + "</script>";

        var Runner = setInterval(function(){
            if(JQueryIsLoaded == 1){
                $("body").prepend(TEMP_B1);
                $("form[role='search']").parent().append('<button aria-label="KIỂM TRA SĐT" role="button" style="cursor:pointer;padding:5px;margin-top:5px;color:red;font-family:Roboto" onclick="KIEM_TRA_SO_DIEN_THOAI()">KIỂM TRA SĐT</button>');
                document.body.addEventListener("click", function(){
                    clearInterval(Runner_Kiem_Tra_SDT);
                    KIEM_TRA_SO_DIEN_THOAI();
                });
                clearInterval(Runner);
            }
        },1000);
    }

})();
