//
// JS > LỆNH JS XỬ LÝ LẤY SỐ LƯỢNG BTC VÀ GIÁ MỖI BTC TRÊN TRANG MEMPOOL.SPACE
// ĐOẠN SCRIPT XỬ LÝ KHI CLICK VÀO NÚT TỔNG BTC/FIAT, TỰ ĐỘNG TÁCH GIÁ TRỊ BTC VÀ USD, TÍNH GIÁ MỖI COIN (USD/BTC) VÀ TẠO THÊM HAI NÚT ĐỂ COPY NHANH SỐ BTC VÀ GIÁ MỖI COIN VÀO CLIPBOARD.

function copyValue(Eleme) {
	navigator.clipboard.writeText($(Eleme).text()).then(() => {
		console.log($(Eleme).text());
		alert("Copy Done");
	}).catch(err => {
		console.error('Error: ', err);
	});
}
$("head").append('<script>' + copyValue.toString() + '</script>');
$("div.header-bg.box > div.summary").find("app-amount").parent("button.btn-success").click(function(){
	var button = $(this);
	var symbol = button.find("span.symbol");
	if(symbol.length == 1){
		if(symbol.text().trim() == "BTC"){
			var btc_amount = button.find("app-amount").text().trim();
			btc_amount = btc_amount.replace("BTC","").replace(" ","").replace("+","").replace(/^[\u200E]+|[\u200E]+$/g,'');
			if(button.attr("btc_amount") == undefined){button.attr("btc_amount", btc_amount)}
		}
	} else {
		var fiat = button.find("span.fiat");
		if(fiat.length == 1){
			var fiat_amount = fiat.text().trim().replace("+","").replace("$","");
			if(button.attr("fiat_amount") == undefined) {
				button.attr("fiat_amount", fiat_amount);
			}
		}
	}
	if(button.attr("fiat_amount") !== undefined && button.attr("btc_amount") !== undefined){
		var fiat = parseFloat(button.attr("fiat_amount").trim());
		var btc = parseFloat(button.attr("btc_amount").trim());
		var price_per_coin = fiat / btc;
		button.attr("price_per_coin", price_per_coin);
	}
	if(button.attr("price_per_coin") !== undefined){
		var button_btc = '<button id="button_btc_for_copy" type="button" class="btn btn-sm btn-primary mt-2" style="margin-left:8px" onclick="copyValue(this)">' + button.attr("btc_amount") + '</button>';
		var button_price_per_coin = '<button id="button_price_per_coin_for_copy" type="button" class="btn btn-sm btn-primary mt-2" style="margin-left:8px" onclick="copyValue(this)">' + button.attr("price_per_coin") + '</button>';
		button.parent().find("#button_btc_for_copy").remove();
		button.parent().find("#button_price_per_coin_for_copy").remove();
		$(button_price_per_coin).insertAfter(button);
		$(button_btc).insertAfter(button);
	}
});
alert("Done");