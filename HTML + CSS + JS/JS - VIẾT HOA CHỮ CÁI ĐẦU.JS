//
// JS -> VIẾT HOA CHỮ CÁI ĐẦU

const UpperCaseWords = (s) =>
  s
    .split(" ")
    .map((w) => `${w.charAt(0).toUpperCase()}${w.slice(1)}`)
    .join(" ");
var Name = UpperCaseWords("nguyễn văn abc");
console.log(Name);
