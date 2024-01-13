# Story Trees

## Description

Scripts to generate an html page with a choose-your-own-adventure type story in the shape of a binary tree.

## Examples

* [A kitten story](https://danielesplin-files.s3.amazonaws.com/public/stories/kitten/index.html)
* [A horse story](https://danielesplin-files.s3.amazonaws.com/public/stories/horse/index.html)

This project started as a present for my kids Christmas 2023.

## Usage

To create a new story create a subdirectory in `data`: `mkdir data/unicorn`.

In that subdirectory create a `leaves.yaml` file with the following structure:

```yaml
---
'0':
  :content:
  - Once there was a choice to go
  :left: left
  :right: right
1l:
  :content:
  - The user chose the left branch and now chooses a color
  :left: red
  :right: blue
1r:
  :content:
  - The user chose the right branch.
  - This is the end of the story because this leaf has no left and right options.
2ll:
  :content:
  - The 2 shows how deep we are in the tree and the `l`s and `r`s are for left or right.
2lr:
  :content:
  - The user chose left and then blue.
```

Create png images in the subdirectory named for each leaf: `0.png`, `1l.png`, `1r.png`, `2ll.png` and `2.lr.png`.

Run `bin/compile`. This takes `index.html` as the layout and inserts everything from the `data` subdirectories and saves it to `out`.

`bin/watcher` will run `bin/compile` every second to make local development easier.

Set the environment variables in `.env` and run `bin/deploy` to upload the files in the `out` directory to an S3 bucket.

## Technology

These pages are running Ruby natively in the browser via WebAssembly (https://github.com/ruby/ruby.wasm) because I like writing Ruby better than JavaScript and wanted an excuse to try it out.

The AI images were generated by [Fooocus](https://github.com/lllyasviel/Fooocus) running on a temporary EC2 instance.
