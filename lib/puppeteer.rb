require "puppeteer-ruby"

url = "ws://127.0.0.1:9222/devtools/browser/623f0073-eb5e-42b4-b41a-425a9e5b814f"

Puppeteer.connect(browser_ws_endpoint: url) do |browser|
  page = browser.new_page
  page.viewport = Puppeteer::Viewport.new(width: 1280, height: 800)
  page.goto("http://localhost:3000/dashboard")
end
