import uvicorn
import os
import sys
import multiprocessing

# Ensure core is in path
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

try:
    from core.main import app
except ImportError as e:
    print(f"Error importing app: {e}")
    sys.exit(1)

if __name__ == "__main__":
    multiprocessing.freeze_support()
    print("Starting NexusReader Backend Service...")
    print("Listening on http://0.0.0.0:8000")
    uvicorn.run(app, host="0.0.0.0", port=8000, log_level="info")
