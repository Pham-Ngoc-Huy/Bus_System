# Assignment 2 (sep style)

## Part: Adjust

### `/www/index.html`
- Different from the previous version, the CSS is now separated into an external file.
- Updated structure:
  ```
  www/
  ├── index.html
  ├── style.css
  ├── hehe.png
  ```
- Changes in `index.html`:
  - From:
    ```html
    <style>
      body {
        background-color: lightsalmon;
      }
      h1 {
        color: black;
        text-align: center;
      }
      p {
        font-family: monospace;
        font-size: 20px;
        text-align: center;
      }
      .center {
        display: block;
        margin-left: auto;
        margin-right: auto;
        width: 50%;
      }
    </style>
    ```
  - To:
    ```html
    <link rel="stylesheet" href="style.css">
    ```

### `style.css`
```css
body {
    background-color: lightsalmon;
}
h1 {
    color: black;
    text-align: center;
}
p {
    font-family: monospace;
    font-size: 20px;
    text-align: center;
}
.center {
    display: block;
    margin-left: auto;
    margin-right: auto;
    width: 50%;
}
```

## Server Management

### Run the Server (Windows):
```sh
./server_start.bat
```

### Stop the Server (Windows):
```sh
./server_stop.bat
```

## Hosting Information
- Hosted on: `localhost:80`
- Configuration file adjusted.
- You can verify settings in: `/usr/local/apache2/conf/httpd.conf`.

