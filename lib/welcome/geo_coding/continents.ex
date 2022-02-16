defmodule Welcome.GeoCoding.Continents do
  # Continents boundaries as polygons
  # Roughly created manually using https://www.keene.edu/campus/maps/tool/
  @continents_polygons %{
    south_america: %{
      type: "Polygon",
      coordinates: [
        [
          {-67.1484375, 13.9234039},
          {-77.3437500, 12.2111802},
          {-83.4960938, 1.2303742},
          {-82.6171875, -15.2841851},
          {-77.5195313, -58.3556304},
          {-49.0429688, -56.5594825},
          {-30.2343750, -1.4061088},
          {-67.1484375, 13.9234039}
        ]
      ]
    },
    north_america: %{
      type: "Polygon",
      coordinates: [
        [
          {-4.5703125, 80.3275059},
          {-21.6210938, 83.9236933},
          {-58.0078125, 84.2495868},
          {-165.5859375, 72.5017224},
          {-171.7382813, 59.6233252},
          {-140.9765625, 41.1124688},
          {-86.3085938, 1.4061088},
          {-76.2890625, 11.0059045},
          {-62.7539063, 14.2643831},
          {-4.5703125, 80.3275059}
        ]
      ]
    },
    europe: %{
      type: "Polygon",
      coordinates: [
        [
          {1.0546875, 80.7039967},
          {-30.5859375, 57.7041472},
          {-9.1406250, 33.1375512},
          {6.3281250, 36.5978891},
          {12.4804688, 36.5978891},
          {26.0156250, 34.0162419},
          {25.8398438, 39.6395376},
          {36.3867188, 42.9403392},
          {65.0390625, 70.9022683},
          {75.2343750, 81.9724313},
          {1.0546875, 80.7039967}
        ]
      ]
    },
    africa: %{
      type: "Polygon",
      coordinates: [
        [
          {5.6250000, 36.7388841},
          {-4.9218750, 35.8890501},
          {-12.1289063, 31.0529340},
          {-22.6757813, 11.3507967},
          {16.1718750, -39.9097362},
          {55.7226563, -26.7456104},
          {53.0859375, 12.8974892},
          {44.2968750, 11.1784019},
          {35.6835938, 25.7998912},
          {30.0585938, 32.9902356},
          {5.6250000, 36.7388841}
        ]
      ]
    },
    australia: %{
      type: "Polygon",
      coordinates: [
        [
          {129.7265625, -6.8391696},
          {113.5546875, -20.6327843},
          {100.7226563, -36.7388841},
          {164.3554688, -53.2257684},
          {188.4375000, -32.8426736},
          {170.5078125, -3.5134210},
          {133.0664063, 4.2149431},
          {129.7265625, -6.8391696}
        ]
      ]
    },
    asia: %{
      type: "Polygon",
      coordinates: [
        [
          {132.0117188, 7.8851473},
          {178.9453125, 51.6180165},
          {190.5468750, 62.5933408},
          {191.6015625, 69.6570863},
          {93.6914063, 82.2616987},
          {70.4882813, 75.7156332},
          {51.3281250, 44.4651510},
          {51.3281250, 36.7388841},
          {39.0234375, 43.1971673},
          {25.4882813, 41.2447723},
          {28.1250000, 34.3071439},
          {43.5937500, 11.5230875},
          {52.2070313, 12.7260843},
          {86.3085938, -13.2399455},
          {127.7929688, -11.8673509},
          {132.0117188, 7.8851473}
        ]
      ]
    },
    antartica: %{
      type: "Polygon",
      coordinates: [
        [
          {-192.6562500, -62.5933408},
          {-201.0937500, -86.2210799},
          {186.3281250, -85.5133983},
          {177.1875000, -60.5869673},
          {-192.6562500, -62.5933408}
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