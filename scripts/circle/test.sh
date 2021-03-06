#!/bin/bash

# Copyright 2017 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

rebuild () {
  for dir in packages/*; do
    test -d "$dir" || continue
    cd $dir
    npm rebuild --update-binary
    cd ../../
  done
}

nvm use v4
npm install
npm run lint
node ./scripts/build.js

nvm use v6
rebuild
npm run lint
node ./scripts/build.js

nvm install v7 && nvm use v7
rebuild
npm run lint
node ./scripts/build.js

set +e