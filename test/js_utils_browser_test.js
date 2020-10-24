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

function testArrayJoinJs() {
  const elements = ['Fire', 'Air', 'Water'];
  return testArrayJoin(elements);
}

function testForInArrayJoinJs() {
  const elements = ['Fire', 'Air', 'Water'];
  return testForInArrayJoin(elements);
}

function testArrayJoin(array) {
  return array.join(',');
}
function testForInArrayJoin(array) {
  // Use for in to build a new array
  var newArray = [];
  for (var key in array) {
    newArray.push(array[key]);
  }
  return newArray.join(',');
}