/**
 * textarea에 쓰여질 개행문자(\n)를 DB에서 꺼내올 때 br태그로 치환하여 뿌려줄 수 있도록
 * 치환해주는 함수!!
 */

function replaceAll(str, target, replacement) {
	return str.split(target).join(replacement);
};