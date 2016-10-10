(*
 * Tool for managing my diapositive
 *
 * Copyright (C) 2016  Xavier Van de Woestyne <xaviervdw@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
*)

open Quasar

module Requirement : QuaSlideshow.Configuration =
struct

  let label          = ref None

  let selector       = ".quasar-slide"
  let parent         = Element.getById "quasar-slides"
  let deal_with_data = []
  let succ           = QuaSlideshow.default_succ
  let pred           = QuaSlideshow.default_pred


  let set_label slide =
    match !label with
    | None -> Element.set_data "label" "Hello !" slide
    | Some x -> Element.set_data "label" x slide
                         
  let init_slide ~length ~slides slide =
    match Element.get_data "label" slide with
      | None -> ignore (set_label slide)
      | Some x -> label := Some x


  let update = QuaSlideshow.default_update
                 
  let before  ~length ~slides cursor =
    QuaSlideshow.default_before
      ~length
      ~slides
      cursor
      update
    

end

module Slider = QuaSlideshow.Simple(Requirement)
let () = Slider.start ()
