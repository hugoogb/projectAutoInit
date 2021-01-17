import sys
import os
from github import Github
from dotenv import load_dotenv

load_dotenv()

projects_path = os.getenv("PROJECTS_PATH")
github_username = os.getenv("GITHUB_USERNAME")
github_password = os.getenv("GITHUB_PASSWORD")


def create():
    projectName = str(sys.argv[1])
    os.makedirs(projects_path + projectName)

    github_user = Github(github_username, github_password).get_user()

    github_user.create_repo(projectName)
    print("Succesfully initialized project{}".format(projectName))


if __name__ == "__main__":
    create()
