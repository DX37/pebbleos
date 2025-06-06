/*
 * Copyright 2024 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#pragma once

#include "applib/ui/recognizer/recognizer.h"

#include <stdbool.h>
#include <stdint.h>

//! Attach a recognizer to the app
//! @param recognizer \ref Recognizer to attach
void app_recognizers_attach_recognizer(Recognizer *recognizer);

//! Detach a recognizer from the app
//! @param recognizer \ref Recognizer to detach
void app_recognizers_detach_recognizer(Recognizer *recognizer);
