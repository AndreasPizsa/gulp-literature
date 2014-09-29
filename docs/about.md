[Literature](//github.com/AndreasPizsa/literature) generalizes the idea of Literate CoffeeScript to just any language. It’s just Markdown with code blocks, except that the code blocks are intended to be executed. There are basically only three rules:

* Regular, unfenced code blocks are executable code
* Fenced code blocks are documentation. (That’s handy for usage examples)
* `.litjs` or `.js.md` will result in a `.js` file, `.litc` or `.c.md` will create a `.c` file, etc.
