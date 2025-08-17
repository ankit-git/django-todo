#!/usr/bin/env python
"""Django's command-line utility for administrative tasks."""
import os
import sys
 
def main():
    # Load environment variables early
    from dotenv import load_dotenv  # Only if using python-dotenv
    load_dotenv()
 
    # If you're using python-decouple or django-environ, you might not need this step directly
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'todoApp.settings')
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    execute_from_command_line(sys.argv)
 
if __name__ == '__main__':
    main()
