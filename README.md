# Neon

Digital cellophane

## What does this do?

It overlays a tint colour on your menu bar.

## Why would I want this?

If you have multiple Macs connected to multiple displays that are right
next to each other, it can be a useful at-a-glance indicator of which
display is connected to which Mac. Or maybe you just like colours.

## How do I use it?

Opening the app should tint the menu bar to a default colour. Re-opening
the app from the Finder should make a colour picker appear, which you
can use to change the tint colour. Note that you have to specify an
opacity of less than 100% to continue being able to see menu items.
Switching to any other app will cause the colour picker to disappear.
To quit the app, re-open it from the Finder and press command-q, or do
`pkill Neon` from a shell.

## What is the icon?

`hue = ((x ^ y) * (y ^ x)) / (width * height)`
