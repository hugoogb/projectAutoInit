import sys
import os
from github import Github
from dotenv import load_dotenv

load_dotenv()

projects_path = os.getenv("PROJECTS_PATH")
github_me_username = os.getenv("GITHUB_ME_USERNAME")
github_uni_username = os.getenv("GITHUB_UNI_USERNAME")
github_password = os.getenv("GITHUB_PASSWORD")


def create():
    projectName = str(sys.argv[1])
    userRepo = str(sys.argv[2])
    os.makedirs(projects_path + projectName)

    if userRepo == "-m" or userRepo == "--me":
        github_user = Github(github_me_username, github_password).get_user()
    elif userRepo == "-u" or userRepo == "--uni":
        github_user = Github(github_uni_username, github_password).get_user()

    github_user.create_repo(projectName)
    print("Succesfully initialized project{}".format(projectName))


if __name__ == "__main__":
    create()
