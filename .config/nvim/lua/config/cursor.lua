-- n-v-c-sm:block  -> Normal, Visual, Command, and Select modes use a Block cursor
-- i-ci-ve:ver25   -> Insert, Command-Insert, and Virtual-Replace modes use a Beam (Vertical Bar) cursor
-- r-cr-o:hor20    -> Replace and Operator-pending modes use an Underline cursor

vim.opt.guicursor =
  "n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175"
