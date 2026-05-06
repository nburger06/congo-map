var map = L.map('map').setView([34, -118], 6);

// base map
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);

// raster layers (one per year)
var rasterLayers = {};

for (let year = 2001; year <= 2020; year++) {
  rasterLayers[year] = L.tileLayer(`tiles/${year}/{z}/{x}/{y}.png`);
}

// add first layer
var currentLayer = rasterLayers[2001].addTo(map);

// slider logic
document.getElementById("slider").oninput = function() {
  map.removeLayer(currentLayer);
  currentLayer = rasterLayers[this.value];
  map.addLayer(currentLayer);
};

// load vector layer
fetch("plantations.geojson")
  .then(res => res.json())
  .then(data => {
    L.geoJSON(data).addTo(map);
  });
