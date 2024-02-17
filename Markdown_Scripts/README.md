# Markdown

## Motivation

<p align="justify">I keep my own list of abbreviations and acronyms. To be able to use them here, I had to convert my data into a table.  The next step was the logical conclusion. I wrote two scripts to convert Markdown tables into text and to convert text into Markdown tables. This way I can automatically keep a list in the form of a table in Markdown without having to do a lot of work. I add new abbreviations and acronyms to Markdown table or to text file and I am finished.</p>

## Markdown language

<p align="justify"><code>Markdown</code> in the current context is a lightweight markup language next to other markup languages for creating formatted text using a plain-text editor. I am using for writing <code>nano</code> and <code>gedit</code> preferably.</p>

<p align="justify">Some other markup languages are:</p>

1. General Markup Language (GML)
2. Extensible Markup Language (XML)
3. Hypter Text Markup Language (HTML)
4. Standard Generalized Markup Language (SGML)

## Tables in markdown

<p align="justify">The markdown code for a table looks like:</p>

```markdown
| Col 1                   | Col 2                   |
| :---------------------- | :---------------------- |
| row 1                   | text 1                  |
| row 2                   | text 2                  |
```

## Accessible scripts

<p align="justify">The script <code>make_raw_md.bash</code> reads a markdown table and writes raw data without formatting to a file. I assume that the content of a markdown table as shown in the last section is to be read in. The headline and the formatting line is hereby omited. The content of the table is separated by the delimiter ; in the output file.</p>

<p align="justify">The script <code>make_table_md.bash</code> reads raw data from a file and creates a markdown table which is written to a file. This is the reverse of the way I have just described. The raw data in the text file is taken and then a markdown table is created with headline and formatting.</p>

[1] www&#8203;.markdownguide.org/getting-started/

[2]  docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax

[3]   markdown.de/

<hr width="100%" size="1">

<p align="justify">If you like what I present here, and if it helps you above, donate me a cup of coffee :coffee:. I drink a lot of coffee while programming and writing  :smiley:.</p>

<hr width="100%" size="1">

<p align="center">
<a href="https://www.buymeacoffee.com/zentrocdot" target="_blank"><img src="..\IMAGES\greeen-button.png" alt="Buy Me A Coffee" height="41" width="174"></a>
</p>

<p align="center">I loved the time when you could get also a hamburger :hamburger: for one euro!</p>

<hr width="100%" size="1">

<p align="justify">Here are some other good ways to simply donate a coffee to me via my favourite coins :moneybag:.</p>

<table>
  <tbody>
    <tr>
      <td>TQamF8Q3z63sVFWiXgn2pzpWyhkQJhRtW7</td>
      <td>Tron</td>
    </tr>
    <tr>
      <td>DMh7EXf7XbibFFsqaAetdQQ77Zb5TVCXiX</td>
      <td>Doge</td>
    </tr>
    <tr>
      <td>12JsKesep3yuDpmrcXCxXu7EQJkRaAvsc5</td>
      <td>Bitcoin</td>
    </tr>
    <tr>
      <td>0x31042e2F3AE241093e0387b41C6910B11d94f7ec</td>
      <td>Ethereum</td>
    </tr>
  </tbody>
</table>

<hr width="100%" size="1">

<p align="center">File last modified 17/02/2024</p>
