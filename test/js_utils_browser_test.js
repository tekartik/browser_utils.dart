function Car() {
  /** @type {number} */
  this.distance = 0;
  this.drive = function (distance) {
    if (typeof distance === 'string') {
      this.distance += parseInt(distance);
    } else {
      this.distance += distance;
    }
    return this.distance;
  }
}
