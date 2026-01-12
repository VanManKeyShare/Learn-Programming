//
// JS -> TẠM DỪNG THỰC THI TRONG MỘT KHOẢNG THỜI GIAN NHẤT ĐỊNH (KHÔNG GÂY TREO TRÌNH DUYỆT)

const delay = (Milisecond) =>
  new Promise((resolve) => setTimeout(resolve, Milisecond));

async function runExample() {
  console.log("START");

  // ĐỢI 5 GIÂY MÀ KHÔNG CHẶN TRÌNH DUYỆT
  await delay(5000);

  console.log("END");
}

runExample();
