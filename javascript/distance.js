function checkDistance(event) {
  event.preventDefault();
  document.getElementById('results').classList.remove('invisible');
  document.getElementById('output').innerHTML = 'Loading...';
  document.getElementById('from').classList.remove('border-red-500');
  document.getElementById('to').classList.remove('border-red-500');

  var from = event.currentTarget[0].value
  var max = event.currentTarget[1].value
  var to = event.currentTarget[2].value
  var url = encodeURI(`api/v1/handler?from=${from}&to=${to}`)

  var request = new XMLHttpRequest();
  request.open('GET', url, true);
  request.onload = function() {
    if (this.status == 200) {
      var distance = parseInt(request.responseText);
      document.getElementById('results').classList.remove('invisible');

      if (distance <= max) {
        document.getElementById('output').innerHTML = 'Nice, you deliver to this location!';
      } else {
        document.getElementById('output').innerHTML = "You don't deliver this far!";
      }
    } else {
      document.getElementById('results').classList.add('invisible');

      if (request.responseText == "The 'from' postcode could not be found") {
        document.getElementById('from').classList.add('border-red-500');
      } else if (request.responseText == "The 'to' postcode could not be found") {
        document.getElementById('to').classList.add('border-red-500');
      }
    }
  };
  request.send();
}
