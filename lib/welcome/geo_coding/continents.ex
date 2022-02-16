defmodule Welcome.GeoCoding.Continents do
  # Continents boundaries as polygons
  # Roughly created manually using https://www.keene.edu/campus/maps/tool/
  @continents_polygons %{
    south_america: %{
      type: "Polygon",
      coordinates: [
        [
          {13.9234039, -67.1484375},
          {12.2111802, -77.3437500},
          {1.2303742, -83.4960938},
          {-15.2841851, -82.6171875},
          {-58.3556304, -77.5195313},
          {-56.5594825, -49.0429688},
          {-1.4061088, -30.2343750},
          {13.9234039, -67.1484375}
        ]
      ]
    },
    north_america: %{
      type: "Polygon",
      coordinates: [
        [
          {80.3275059, -4.5703125},
          {83.9236933, -21.6210938},
          {84.2495868, -58.0078125},
          {72.5017224, -165.5859375},
          {59.6233252, -171.7382813},
          {41.1124688, -140.9765625},
          {1.4061088, -86.3085938},
          {11.0059045, -76.2890625},
          {14.2643831, -62.7539063},
          {80.3275059, -4.5703125}
        ]
      ]
    },
    europe: %{
      type: "Polygon",
      coordinates: [
        [
          {80.7039967, 1.0546875},
          {57.7041472, -30.5859375},
          {33.1375512, -9.1406250},
          {36.5978891, 6.3281250},
          {36.5978891, 12.4804688},
          {34.0162419, 26.0156250},
          {39.6395376, 25.8398438},
          {42.9403392, 36.3867188},
          {70.9022683, 65.0390625},
          {81.9724313, 75.2343750},
          {80.7039967, 1.0546875}
        ]
      ]
    },
    africa: %{
      type: "Polygon",
      coordinates: [
        [
          {36.7388841, 5.6250000},
          {35.8890501, -4.9218750},
          {31.0529340, -12.1289063},
          {11.3507967, -22.6757813},
          {-39.9097362, 16.1718750},
          {-26.7456104, 55.7226563},
          {12.8974892, 53.0859375},
          {11.1784019, 44.2968750},
          {25.7998912, 35.6835938},
          {32.99023563, 0.0585938},
          {36.7388841, 5.6250000}
        ]
      ]
    },
    australia: %{
      type: "Polygon",
      coordinates: [
        [
          {-6.8391696, 129.7265625},
          {-20.6327843, 113.5546875},
          {-36.7388841, 100.7226563},
          {-53.2257684, 164.3554688},
          {-32.8426736, 188.4375000},
          {-3.5134210, 170.5078125},
          {4.2149431, 133.0664063},
          {-6.8391696, 129.7265625}
        ]
      ]
    },
    asia: %{
      type: "Polygon",
      coordinates: [
        [
          {7.8851473, 132.0117188},
          {51.6180165, 178.9453125},
          {62.5933408, 190.5468750},
          {69.6570863, 191.6015625},
          {82.2616987, 93.6914063},
          {75.7156332, 70.4882813},
          {44.4651510, 51.3281250},
          {36.7388841, 51.3281250},
          {43.1971673, 39.0234375},
          {41.2447723, 25.4882813},
          {34.3071439, 28.1250000},
          {11.5230875, 43.5937500},
          {12.7260843, 52.2070313},
          {-13.2399455, 86.3085938},
          {-11.8673509, 127.7929688},
          {7.8851473, 132.0117188}
        ]
      ]
    },
    antartica: %{
      type: "Polygon",
      coordinates: [
        [
          {-62.5933408, -192.6562500},
          {-86.2210799, -201.0937500},
          {-85.5133983, 186.3281250},
          {-60.5869673, 177.1875000},
          {-62.5933408, -192.6562500}
        ]
      ]
    }
  }

  def find_continent(lat, long) do
    case Enum.find(@continents_polygons, &Topo.contains?(elem(&1, 1), {lat, long})) do
      nil -> nil
      result -> result
    end
  end
end
