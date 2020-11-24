#
# Copyright (c) 2009-2020. Authors: see NOTICE file.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM node:13.12.0 as build-stage
WORKDIR /app
RUN git clone https://github.com/hale0124/Cytomine-Web-UI.git && cd Cytomine-Web-UI && git checkout v1.2.1
WORKDIR /app/Cytomine-Web-UI
RUN npm install
RUN npm run build

FROM nginx as production-stage
RUN mkdir /app
COPY --from=build-stage /app/Cytomine-Web-UI/dist /app
COPY nginx.conf /etc/nginx/nginx.conf
