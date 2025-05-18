import route from 'ziggy-js'

const Ziggy = {
  "url": "http://localhost",
  "port": null,
  "defaults": {},
  "routes": {
    "sanctum.csrf-cookie": { "uri": "sanctum/csrf-cookie", "methods": ["GET","HEAD"] },
    "dashboard": { "uri": "dashboard", "methods": ["GET","HEAD"] },
    // ... остальные маршруты ...
  }
};

if (typeof window !== 'undefined' && typeof window.Ziggy !== 'undefined') {
  Object.assign(Ziggy.routes, window.Ziggy.routes);
}

export default Ziggy;
export { Ziggy };
