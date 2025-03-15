from app import App

def main():
    app_instance = App()
    try:
        app_instance.run()
    except Exception as e:
        return f"Error: {e}", 404
    
if __name__ == "__main__":
    main()
