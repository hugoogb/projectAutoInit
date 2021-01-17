import sys
import os
from github import Github
from dotenv import load_dotenv

load_dotenv()

projects_path = os.getenv('GITHUB_PROJECTS_PATH')
github_token = os.getenv('GITHUB_TOKEN')


def create():
    projectName = sys.argv[1]
    os.makedirs(projects_path + projectName)

    github = Github(github_token)
    github_user = github.get_user()

    github_user.create_repo(projectName)

    print("Succesfully initialized project {}".format(projectName))


if __name__ == "__main__":
    create()
