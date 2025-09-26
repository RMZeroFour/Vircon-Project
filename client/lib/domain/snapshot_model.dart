class Snapshot {
  bool a;
  bool b;
  bool x;
  bool y;
  bool l1;
  bool r1;
  bool l2;
  bool r2;
  bool dUp;
  bool dDown;
  bool dLeft;
  bool dRight;
  bool select;
  bool start;

  int leftJsX;
  int leftJsY;
  int rightJsX;
  int rightJsY;

  Snapshot({
    this.a = false,
    this.b = false,
    this.x = false,
    this.y = false,
    this.l1 = false,
    this.r1 = false,
    this.l2 = false,
    this.r2 = false,
    this.dUp = false,
    this.dDown = false,
    this.dLeft = false,
    this.dRight = false,
    this.select = false,
    this.start = false,
    this.leftJsX = 0,
    this.leftJsY = 0,
    this.rightJsX = 0,
    this.rightJsY = 0,
  });
}
