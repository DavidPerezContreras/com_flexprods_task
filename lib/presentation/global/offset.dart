double offset = 0;

onOffsetChanged(double newOffset) {
  offset = newOffset;
}

resetGlobalAppState() {
  offset = 0;
}

/* Important. I had to make global variables just because
clicking in BottomNavigationBar rebuilds the whole
widget tree.
*/
