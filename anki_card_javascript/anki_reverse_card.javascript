<div>
	<span id="word_blanks" style="font-size:30px"></span>
	<span id="word_count" style="font-size:18px"></span>
</div>

{{definition}}

<script>
/* TRANSPARENT TARGET WORD */
function set_transparent(elem) {
  elem.style.color = "transparent";
  elem.style.textDecoration = "underline";
  elem.style.textDecorationColor = "red";
}

let bqs = document.getElementsByTagName('blockquote');
for(let i = 0;i < bqs.length; i++)
{
  let bs = bqs[i].getElementsByTagName('b');
  for(let j = 0;j < bs.length; j++)
  {
  	let elems = bs[j].getElementsByTagName('*');
  	for(let k = 0;k < elems.length; k++){
      set_transparent(elems[k])
    }
    set_transparent(bs[j])
  }
}

/* DISPLAY NUM WORDS */
let word = "{{traditional}}";
document.getElementById("word_blanks").innerHTML = "_ ".repeat(word.length)
document.getElementById("word_count").innerHTML = `(${word.length})`;
</script>