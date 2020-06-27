function checkDistance(event) {
  event.preventDefault();

  document.getElementById('output').innerHTML = 'Loading...';

  var from = event.currentTarget[0].value
  var max = event.currentTarget[1].value
  var to = event.currentTarget[2].value
  var url = encodeURI(`api/v1/handler?from=${from}&to=${to}`)

  var request = new XMLHttpRequest();
  request.open('GET', url, true);
  request.onload = function() {
    if (this.status == 200) {
      var distance = parseInt(request.responseText);

      if (distance <= max) {
        document.getElementById('output').innerHTML = 'Nice, you deliver to this location!';
      } else {
        document.getElementById('output').innerHTML = "You don't deliver this far!";
      }
    } else {
      document.getElementById('output').innerHTML = 'Error: ' + request.responseText;
    }
  };
  request.send();
}
