//
// JS -> CONVERT BASE64 STRING TO UTF-8 STRING

function BASE64_TO_UTF8(DATA) {
  const BINARY_STRING = atob(DATA);
  const BYTES = new Uint8Array(BINARY_STRING.length);
  for (let i = 0; i < BINARY_STRING.length; i++) {
    BYTES[i] = BINARY_STRING.charCodeAt(i);
  }
  return new TextDecoder().decode(BYTES);
}
